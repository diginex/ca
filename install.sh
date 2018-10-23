#!/bin/sh
sudo docker run --rm diginex/ca getScript > /usr/local/bin/ca
sudo chmod a+x /usr/local/bin/ca