#!/bin/bash

# añadir tantas líneas como sean necesarias para el correcto despligue
ansible-playbook -i hosts 01-ini-configuration.yaml
ansible-playbook -i hosts 02-nfs-configuration.yaml
ansible-playbook -i hosts 03-k8s-cluster-configuration.yaml
ansible-playbook -i hosts 04-k8s-master-configuration.yaml
# Guardar salida del paso 04 output_join_command.stdout_lines. Opciones: 
# (1) Actualizar variable "comando" en "/group_vars/k8s-worker-configuration.yaml" 
# (2) Lanzar ansible-playbook -i hosts 08-k8s-cluster-add-worker.yaml con ese valor --extra-vars "comando='salida del paso 04'"
ansible-playbook -i hosts 05-k8s-cluster-usuario.yaml
ansible-playbook -i hosts 06-k8s-master-sdn.yaml
ansible-playbook -i hosts 07-k8s-master-ingress.yaml
ansible-playbook -i hosts 08-k8s-worker-configuration.yaml  --extra-vars "comando='salida del paso 04'"
ansible-playbook -i hosts 09-app-desploy-mysql.yaml