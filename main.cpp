#include <iostream>
#include <time.h>

#include "md5.hpp"
#include "sha1.hpp"
#include "sha224.hpp"
#include "sha256.hpp"
#include "sha384.hpp"
#include "sha512.hpp"

using std::string;
using std::cout;
using std::endl;

void testMD5(string input);
void testSHA1(string input);
void testSHA224(string input);
void testSHA256(string input);
void testSHA384(string input);
void testSHA512(string input);

struct timespec start, finish;
double elapsed;
double oneMinuteCicles;

int main(int argc, char *argv[])
{
    string input = "grape";

    //cout << "md5('" << input << "'): " << md5(input) << endl;
    /* MD5 Test START */
    testMD5(input);
    /* MD5 Test STOP */
    //cout << "sha1('" << input << "'): " << sha1(input) << endl;
    /* SHA1 Test START */
    testSHA1(input);
    /* SHA1 Test STOP */
    //cout << "sha224('" << input << "'): " << sha224(input) << endl;
    /* SHA224 Test START */
    testSHA224(input);
    /* SHA224 Test STOP */
    //cout << "sha256('" << input << "'): " << sha256(input) << endl;
    /* SHA256 Test START */
    testSHA256(input);
    /* SHA256 Test STOP */
    //cout << "sha384('" << input << "'): " << sha384(input) << endl;
    /* SHA384 Test START */
    testSHA384(input);
    /* SHA384 Test STOP */
    //cout << "sha512('" << input << "'): " << sha512(input) << endl;
    /* SHA512 Test START */
    testSHA512(input);
    /* SHA512 Test STOP */
    return 0;
}

void testMD5(string input)
{
    clock_gettime(CLOCK_MONOTONIC, &start);
    md5(input);
    clock_gettime(CLOCK_MONOTONIC, &finish);
    elapsed = (finish.tv_sec - start.tv_sec);
    elapsed += (finish.tv_nsec - start.tv_nsec) / 1000000000.0;
    oneMinuteCicles = 60 / elapsed;
    cout << "MD5(One Cicle): " << elapsed << endl;
    cout << "MD5(cpm): " << oneMinuteCicles << endl;
}

void testSHA1(string input)
{
    clock_gettime(CLOCK_MONOTONIC, &start);
    sha1(input);
    clock_gettime(CLOCK_MONOTONIC, &finish);
    elapsed = (finish.tv_sec - start.tv_sec);
    elapsed += (finish.tv_nsec - start.tv_nsec) / 1000000000.0;
    oneMinuteCicles = 60 / elapsed;
    cout << "SHA1(One Cicle): " << elapsed << endl;
    cout << "SHA1(cpm): " << oneMinuteCicles << endl;
}

void testSHA224(string input)
{
    clock_gettime(CLOCK_MONOTONIC, &start);
    sha224(input);
    clock_gettime(CLOCK_MONOTONIC, &finish);
    elapsed = (finish.tv_sec - start.tv_sec);
    elapsed += (finish.tv_nsec - start.tv_nsec) / 1000000000.0;
    oneMinuteCicles = 60 / elapsed;
    cout << "SHA224(One Cicle): " << elapsed << endl;
    cout << "SHA224(cpm): " << oneMinuteCicles << endl;
}

void testSHA256(string input)
{
    clock_gettime(CLOCK_MONOTONIC, &start);
    sha256(input);
    clock_gettime(CLOCK_MONOTONIC, &finish);
    elapsed = (finish.tv_sec - start.tv_sec);
    elapsed += (finish.tv_nsec - start.tv_nsec) / 1000000000.0;
    oneMinuteCicles = 60 / elapsed;
    cout << "SHA256(One Cicle): " << elapsed << endl;
    cout << "SHA256(cpm): " << oneMinuteCicles << endl;
}

void testSHA384(string input)
{
    clock_gettime(CLOCK_MONOTONIC, &start);
    sha384(input);
    clock_gettime(CLOCK_MONOTONIC, &finish);
    elapsed = (finish.tv_sec - start.tv_sec);
    elapsed += (finish.tv_nsec - start.tv_nsec) / 1000000000.0;
    oneMinuteCicles = 60 / elapsed;
    cout << "SHA384(One Cicle): " << elapsed << endl;
    cout << "SHA384(cpm): " << oneMinuteCicles << endl;
}

void testSHA512(string input)
{
    clock_gettime(CLOCK_MONOTONIC, &start);
    sha512(input);
    clock_gettime(CLOCK_MONOTONIC, &finish);
    elapsed = (finish.tv_sec - start.tv_sec);
    elapsed += (finish.tv_nsec - start.tv_nsec) / 1000000000.0;
    oneMinuteCicles = 60 / elapsed;
    cout << "SHA512(One Cicle): " << elapsed << endl;
    cout << "SHA512(cpm): " << oneMinuteCicles << endl;
}
