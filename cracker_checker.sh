#!/bin/bash

HASH1=`perl -e 'print crypt("hello", "aa");'`
HASH2=`perl -e 'print crypt("annex", "aa");'`
HASH3=`perl -e 'print crypt("Being", "aa");'`

ANS1=`./cracker AAAAA ABAAA $HASH1` #NO
ANS2=`./cracker AAAAA ABAAA $HASH2` #NO
ANS3=`./cracker BAAAA CAAAA $HASH3` #YES

if [ $ANS1 != "NO" ]
then
	echo "Test 1 failed."
fi

if [ $ANS2 != "NO" ]
then
	echo "Test 2 failed."
fi

if [ $ANS3 != "YES" ]
then
	echo "Test 3 failed."
fi

echo "Done testing."
