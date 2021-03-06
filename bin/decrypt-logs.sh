#!/bin/bash

# To create a new certificate
# openssl req -newkey rsa:2048 -nodes -keyout privateKey.pem -x509 -out send-logs.pem
# openssl x509 -outform der -in send-logs.pem -out send-logs.der
# Replace send-logs.der in Tunnelbear iOS and be sure to use privateKey.pem

# Configuration
privateKey=privateKey.pem
ciphertextKey=ciphertext.key
ciphertextData=ciphertext.data
tmpFile=$(mktemp /tmp/ios-logs.zip.XXXXXX)
outputDir="./"

while (( "$#" )) 
do 
	case $1 in 
		-k)
			ciphertextKey="$2"
			shift 2
			;;
		--private-key)
			ciphertextKey="$2"
			shift 2
			;;
		--tmp-file)
			tmpFile="$2"
			shift 2
			;;
		-d)
			ciphertextData="$2"
			shift 2
			;;
		-o)
			outputDir="$2"
			shift 2
			;;
	esac
done


plaintextKey=$(openssl rsautl -decrypt -inkey $privateKey -in $ciphertextKey)
set -- $plaintextKey
openssl aes-256-cbc -K $1 -iv $2 -d -in $ciphertextData -out $tmpFile
mkdir -p $outputDir
cd $outputDir
unzip $tmpFile
cd -
rm $tmpFile
