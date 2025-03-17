#include <iostream>
#include <fstream>
#include <vector>
#include <thread>
#include <chrono>
#include <string>

int main() {
    const int maxFiles = 65535;
    const int totalFiles = 100000;
    const int batchSize = 1000;
    bool errorOccurred = false;
    
    std::cout << "Current file descriptor limit: " << maxFiles << std::endl;

    std::vector<std::ofstream*> openFiles;
    openFiles.reserve(totalFiles);

    for (int i = 0; i < totalFiles; ++i) {
        std::string fileName = "tempfile_" + std::to_string(i) + ".txt";
        std::ofstream* filePtr = new std::ofstream(fileName);
        
        if (!filePtr->is_open()) {
            std::cerr << "Error: Failed to open file " << fileName << " at count " << i << std::endl;
            delete filePtr;
            errorOccurred = true;
            break;
        }

        *filePtr << "This is file number " << i << "\n";
        openFiles.push_back(filePtr);

        if ((i + 1) % batchSize == 0) {
            std::cout << "Opened " << i + 1 << " files. Sleeping for 1 second..." << std::endl;
            std::this_thread::sleep_for(std::chrono::seconds(1));
        }
    }
    
    if (!errorOccurred) {
        std::cout << "Successfully opened " << totalFiles << " files." << std::endl;
    }

    for (auto filePtr : openFiles) {
        if (filePtr) {
            filePtr->close();
            delete filePtr;
        }
    }
    
    return 0;
}
