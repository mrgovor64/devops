#!/bin/bash
echo "prepare install"
sudo apt install --assume-yes apt-transport-https
wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-7.x.list
sudo apt update

echo "install elastic"
sudo apt install --assume-yes elasticsearch=7.12.0

sudo sh -c "echo 'node.name: node-1' >> /etc/elasticsearch/elasticsearch.yml"
sudo sh -c "echo 'network.host: 0.0.0.0' >> /etc/elasticsearch/elasticsearch.yml"
sudo sh -c "echo 'cluster.initial_master_nodes: node-1' >> /etc/elasticsearch/elasticsearch.yml"

sudo sh -c "echo '-Xms512m' >> /etc/elasticsearch/jvm.options"
sudo sh -c "echo '-Xmx512m' >> /etc/elasticsearch/jvm.options"

echo "start elastic"
sudo systemctl start elasticsearch
sudo systemctl enable elasticsearch

curl -X GET 'http://localhost:9200'

echo "install kibana"
sudo apt install --assume-yes kibana=7.12.0
sudo sh -c "echo 'server.host: \"0.0.0.0\"' >> /etc/kibana/kibana.yml"
sudo sh -c "echo 'elasticsearch.hosts: [\"http://localhost:9200\"]' >> /etc/kibana/kibana.yml"

echo "start kibana"
sudo systemctl start kibana
sudo systemctl enable kibana
