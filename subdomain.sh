#!/bin/bash 

domain=$1
mkdir $1

subfinder -d $1 -silent | tee -a $1/subs.txt
assetfinder -subs-only $1 | tee -a $1/subs.txt
amass enum -r 0.0.0.0 -passive -d $1 | tee -a $1/subs.txt
                                                                                                                                                                                                       cat $1/subs.txt | httpx -silent | tee -a $1/alive.txt              

cat $1/subs.txt | xargs -I @ dig @ | grep -E 'CNAME'

## test for nuclei 

#cat $1/alive.txt | nuclei -t /home/shuvo/nuclei-templates -es info,unknown -etags ssl,network | tee -a $1/nuclei.txt
