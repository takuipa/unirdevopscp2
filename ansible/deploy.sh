#!/bin/bash

# añadir tantas líneas como sean necesarias para el correcto despligue
ansible-playbook -i hosts -l ini-01-configuration.yaml
ansible-playbook -i hosts -l nfs-01-configuration.yaml
ansible-playbook -i hosts -l k8s-01-master.yaml
ansible-playbook -i hosts -l k8s-02-worker.yaml
ansible-playbook -i hosts -l k8s-03-ingress.yaml