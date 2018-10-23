#!/bin/sh
sudo docker run diginex/ca getScript > /usr/local/bin/ca
sudo chmod a+x /usr/local/bin/ca