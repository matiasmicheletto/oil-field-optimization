#ifndef MODEL_H
#define MODEL_H

#include <algorithm>
#include "../util/util.h"

enum FEAS_CODE {FEASIBLE, RATE_VAL, RATE_LEN, GROSS_TOL};
std::string getFeasibilityDefinition(FEAS_CODE code);

struct Well { // Well production properties
    double maxGross; // Max gross production of the well
    double maxNet; // Max net production of the well
    double initialRate; // Pumping rate in range 0..1
};

struct ModelConfig { // Model config
    double targetGross; // Production target gross in m3/day.  
    double tolerance; // Tolerance for target gross in m3/day.  

    // Default values:
    ModelConfig() : 
        targetGross(10.0),
        tolerance(10.0) {}
};

struct ModelRawData { // Matrix for parameters and distance values
    std::vector<std::vector<double>> wellParams;
    std::vector<std::vector<double>> distanceMatrix;
};

struct Solution {
    FEAS_CODE feasibility;
    double productionLoss;
    double grossError;
    double travelCost;
    double productionGross;
    uint travelCount;
    
    // Default values:
    Solution() : 
        feasibility(FEAS_CODE::FEASIBLE),
        productionLoss(0.0),
        grossError(__DBL_MAX__),
        travelCost(0.0),
        productionGross(0.0),
        travelCount(0) {}

    void printObjectives() {
        std::cout << "  Feasibility status: " << getFeasibilityDefinition(feasibility) << std::endl;
        std::cout << "  Production loss: " << productionLoss << " m³/day" << std::endl;
        std::cout << "  Travel cost: " << travelCost << std::endl;
        std::cout << "  Gross production error: " << grossError << " m³/day" << std::endl;

        std::cout << "Other parameters:" << std::endl;
        std::cout << "  Gross production: " << productionGross << " m³/day" << std::endl;
        std::cout << "  Travel count: " << travelCount << std::endl;
    }
};

bool dominates(const Solution& A, const Solution& B);
bool equivalent(const Solution& A, const Solution& B);
bool findSolution(const Solution& key, const std::vector<Solution>& list);

class Model { // Provides attributes and funcions related to problem formulation
    public:
        Model(ModelRawData rawData, ModelConfig config);
        ~Model();
        
        Solution eval(std::vector<double> rates);

        void setConfig(ModelConfig config);
        void printConfig();
        void printInitialRates();

        inline ModelConfig getConfig() { return this->config; };
        inline uint getWellCount() { return this->wellCount; };
        inline double getInitialGross() { return this->initialGross; };
        inline Well getWell(uint index) { return this->wells[index]; };
        std::vector<double> getInitialRates();
        
    private:
        ModelConfig config;
        std::vector<Well> wells;
        std::vector<std::vector<double>> distanceMatrix;
        double initialGross;
        double initialLoss;
        double initialNet;
        uint wellCount;
};

#endif // MODEL_H