#include <iostream>
#include <fstream>
#include <vector>
#include <thread>
#include <chrono>
#include <string>
#include <memory>

int main() {
    std::vector<std::unique_ptr<std::ofstream>> fileStreams;
    fileStreams.reserve(100);

    for (int count = 1; count <= 100; ++count) {
        std::string* pFileName = new std::string("file_" + std::to_string(count) + ".txt");

        std::unique_ptr<std::ofstream> pFileStream(new std::ofstream(pFileName->c_str()));
        delete pFileName;

        if (!pFileStream || !pFileStream->is_open()) {
            std::cerr << "Error: Cannot open file file_" << count << ".txt\n";
            return 1;
        }

        *pFileStream << "File number: " << count << "\n";
        pFileStream->flush();
        
        fileStreams.push_back(std::move(pFileStream));

        std::this_thread::sleep_for(std::chrono::seconds(1));
    }

    std::cout << "Successfully created 100 files.\n";
    return 0;
}
