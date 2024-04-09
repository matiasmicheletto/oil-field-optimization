#ifndef UTIL_H
#define UTIL_H

#include <iostream>
#include <fstream>
#include <chrono>
#include <sstream>
#include <cstring>
#include <vector>

#define EPSILON 0.001

struct OptimizationConfig { // Extend for each case
    uint timeout;
    uint maxIters;
    OptimizationConfig() : timeout(10000), maxIters(100) {}
};

uint getElapsed(std::chrono::_V2::system_clock::time_point start);
bool isTimeout(std::chrono::_V2::system_clock::time_point start, uint timeout);

std::vector<std::vector<double>> parseCSVFile(std::string filename, int colsnum = -1, bool withHeader = false);
void printTextFile(const char* file);

inline bool areEqual(double x, double y) {return (std::abs(x-y) < EPSILON);}

inline double clamp(double value, double min, double max) {
    return std::max(min, std::min(value, max));
}

void printVector(std::vector<double> vector);

#endif // UTIL_H

