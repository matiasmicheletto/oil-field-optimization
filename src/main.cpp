#define MANUAL "manual.txt"

#include "model/model.h"
#include "optimizers/random_search/random_search.hpp"

struct SystemParams {
    ModelConfig modelConfig;
    OptimizationConfig optimizationConfig;
    //GAConfig gaConfig;
    std::string paramsFileName;
    std::string outputFileName;
    std::string distanceFileName;
};

SystemParams getParams(int argc, char ** argv);
void analyzeModel(std::string paramsFilename);

int main(int argc, char **argv) {

    srand(time(NULL));

    SystemParams params = getParams(argc, argv);

    ModelRawData rawData = {
        parseCSVFile(params.paramsFileName, 3, true),
        parseCSVFile(params.distanceFileName)
    };
    Model model(rawData, params.modelConfig);
    
    #ifdef VERBOSE
        model.printConfig();
        std::cout << "Optimization parameters: " << std::endl;
        std::cout << "  timeout: " << params.optimizationConfig.timeout << " ms" << std::endl;
        std::cout << "  objective fc. max calls: " << params.optimizationConfig.maxIters << std::endl;
    #endif

    OptimizationResults res = randomSearch(model, params.optimizationConfig);

    std::cout << "Optimization finished. Results: " << std::endl;
    res.print();

    res.exportSolutions(params.outputFileName);
    std::cout << "Pareto front values exported to .csv file." << std::endl;
    
    return 0;
}


SystemParams getParams(int argc, char **argv) {
    SystemParams params;
    bool analyzeInput = false;
    for(int i = 0; i < argc; i++) {
        if(strcmp(argv[i], "-h") == 0 || strcmp(argv[i], "--help") == 0 || argc == 1)
            printTextFile(MANUAL);
        if(strcmp(argv[i], "-p") == 0 || strcmp(argv[i], "--params") == 0) {
            if(i+1 < argc)
                params.paramsFileName = argv[i + 1];
            else{
                printTextFile(MANUAL);
                std::cerr << std::endl << "Error in argument -p (--params)" << std::endl;
            }
        }
        if(strcmp(argv[i], "-a") == 0 || strcmp(argv[i], "--analyze") == 0) {
            analyzeInput = true;
        }
        if(strcmp(argv[i], "-d") == 0 || strcmp(argv[i], "--distances") == 0) {
            if(i+1 < argc)
                params.distanceFileName = argv[i + 1];
            else{
                printTextFile(MANUAL);
                std::cerr << std::endl << "Error in argument -d (--distances)" << std::endl;
            }
        }
        if(strcmp(argv[i], "-o") == 0 || strcmp(argv[i], "--output") == 0) {
            if(i+1 < argc)
                params.outputFileName = argv[i + 1];
            else{
                printTextFile(MANUAL);
                std::cerr << std::endl << "Error in argument -o (--output)" << std::endl;
            }
        }
        if(strcmp(argv[i], "-g") == 0 || strcmp(argv[i], "--gross") == 0){
            if(i+1 < argc)
                params.modelConfig.targetGross = atof(argv[i+1]);
            else{
                printTextFile(MANUAL);
                std::cerr << std::endl << "Error in argument --gross (-g)" << std::endl;
            }
        }
        if(strcmp(argv[i], "-l") == 0 || strcmp(argv[i], "--tol") == 0){
            if(i+1 < argc)
                params.modelConfig.tolerance = atof(argv[i+1]);
            else{
                printTextFile(MANUAL);
                std::cerr << std::endl << "Error in argument --tol (-l)" << std::endl;
            }
        }
        if(strcmp(argv[i], "-t") == 0 || strcmp(argv[i], "--timeout") == 0) {
            if(i+1 < argc) 
                params.optimizationConfig.timeout = atoi(argv[i+1])*1000; // Convert to ms
            else{
                printTextFile(MANUAL);
                std::cerr << std::endl << "Error in argument --timeout (-t)" << std::endl;
            }
        }
        if(strcmp(argv[i], "-i") == 0 || strcmp(argv[i], "--iters") == 0) {
            if(i+1 < argc) 
                params.optimizationConfig.maxIters = atoi(argv[i+1]);
            else{
                printTextFile(MANUAL);
                std::cerr << std::endl << "Error in argument --iters (-i)" << std::endl;
            }
        }
    }

    if(analyzeInput){
        analyzeModel(params.paramsFileName);
        exit(0);
    }

    return params;
}

void analyzeModel(std::string paramsFilename) {
    std::vector<std::vector<double>> data = parseCSVFile(paramsFilename, 3, true);
    double initialGross = 0.0;
    double initialNet = 0.0;
    for(uint w = 0; w < data.size(); w++){
        const double gross = data[w][0];
        const double net = data[w][1];
        const double rate = data[w][2]/100.0; // Well rates are expressed in %
        if(rate < 0.0 || rate > 1.0){
            std::cerr << std::endl << "Error in model configuration. A well cannot have a rate below the minimum configured." << std::endl;
            std::cerr << "In line " << w << ", rate value is " << rate*100.0 << std::endl;
            exit(1);
        }
        if(gross < net){
            std::cerr << std::endl << "Error in model configuration. Net value cannot be grater than gross." << std::endl;
            std::cerr << "In line " << w << ", gross value is" << gross << " and net is " << net << std::endl;
            exit(1);
        }
        initialGross += gross * rate;
        initialNet += net * rate;
    }
    std::cout << "Initial gross: " << initialGross << " m³/day" << std::endl;
    std::cout << "Initial net: " << initialNet << " m³/day" << std::endl;
    std::cout << "Initial loss: " << initialGross - initialNet << " m³/day" << std::endl;
}



/* TESTS

std::vector<double> initialRates = {82, 23, 18, 15.8, 27, 15, 24, 12, 12, 28, 92.3, 12, 92, 81, 23, 18, 15, 27, 15, 24, 12, 12, 28, 81, 12, 92, 82, 23, 18, 15, 27, 15, 24, 12, 12, 28, 89, 12, 92, 82, 23, 18, 15, 27, 15, 24, 12, 12, 28, 89, 12, 92};
    std::vector<double> newRates = {82, 23, 18, 15, 27, 15, 24, 12, 12, 28, 89, 12, 92, 81, 23, 18, 15, 27, 15, 24, 12, 12, 28, 81, 12, 92, 82, 23, 18, 15, 27, 15, 24, 12, 12, 28, 89, 12, 92, 82, 23, 18, 15, 27, 15, 24, 12, 12, 28, 89, 12, 92};
    for(uint i = 0; i < newRates.size(); i++){
        newRates[i] = newRates[i]/100.0;
    }
    Solution temp = model.eval(newRates);
    temp.printObjectives();

*/