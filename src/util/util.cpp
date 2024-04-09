#include "util.h"

uint getElapsed(std::chrono::_V2::system_clock::time_point start) {
    auto currentTime = std::chrono::high_resolution_clock::now();
    auto elapsedMs = std::chrono::duration_cast<std::chrono::milliseconds>(currentTime - start).count();
    return (uint)elapsedMs;
}

bool isTimeout(std::chrono::_V2::system_clock::time_point start, uint timeout) {
    return getElapsed(start) >= timeout;
}

void printTextFile(const char* file) { // Open readme file with manual and print on terminal   
    std::ifstream manualFile(file);
    if (manualFile.is_open()) {
        std::string line;
        while (getline(manualFile, line)) {
            std::cout << line << std::endl;
        }
        manualFile.close();
    } else {
        std::cerr << "Error: Unable to open manual file." << std::endl;
    }
    exit(1);
}

std::vector<std::vector<double>> parseCSVFile(std::string filename, int colsnum, bool withHeader) {
    
    #ifdef VERBOSE
        std::cout << "Reading file " << filename << "... ";
    #endif

    std::ifstream file(filename);
    if (!file) {
        std::cerr << std::endl << "Failed to open input file. Check filename or file location." << std::endl;
        exit(1);
    }

    // Read csv file data
    std::string header;
    if(withHeader)
        std::getline(file, header); // Read and discard header
    std::string line;
    std::vector<std::vector<double>> data;
    while (std::getline(file, line)) {

        std::vector<double> row;
        std::stringstream ss(line);
        std::string cell;
        
        while (std::getline(ss, cell, ','))
            row.push_back(std::stof(cell));
        
        if(colsnum > 0){ // Check number of columns
            if(row.size() == (uint) colsnum)
                data.push_back(row);
            else{
                std::cerr << std::endl << "Error while parsing input file. All rows must contain " << colsnum << " columns." << std::endl;
                exit(1);
            }
        }else{
            data.push_back(row);
        }
    }
    file.close();

    #ifdef VERBOSE
        std::cout << "File parsed successfully." << std::endl;
    #endif

    return data;
}

void printVector(std::vector<double> vector) {
    for(uint i = 0; i < vector.size(); i++)
        std::cout << vector[i] << " ";
    std::cout << std::endl;
}