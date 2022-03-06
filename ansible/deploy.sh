#!/bin/bash

# añadir tantas líneas como sean necesarias para el correcto despligue
ansible-playbook -i hosts.local -l cnf-01-configuracion-inicial.yaml
ansible-playbook -i hosts.local -l nfs-01-general.yaml
ansible-playbook -i hosts.local -l k8s-01-master.yaml
ansible-playbook -i hosts.local -l k8s-02-worker.yaml
ansible-playbook -i hosts.local -l k8s-03-ingress.yaml