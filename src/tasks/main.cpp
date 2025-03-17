#include <fstream>
#include <thread>
#include <chrono>
#include <iostream>
#include <string>

int main() {
    std::fstream* pFile = new std::fstream("test.txt");
    
    if (!pFile || !pFile->is_open()) {
        std::cerr << "Error: Unable to open test.txt\n";
        delete pFile;
        return 1;
    }

    for (int lineIndex = 0; lineIndex < 1000; ++lineIndex) {
        std::this_thread::sleep_for(std::chrono::seconds(1));
        *pFile << "#$# " << lineIndex << "\n" << std::flush;
    }

    pFile->close();
    delete pFile;
    return 0;
}
