#!/bin/bash

# añadir tantas líneas como sean necesarias para el correcto despligue
ansible-playbook -i hosts 01-ini-configuration.yaml # configuracion inicial de todos las máquinas
ansible-playbook -i hosts 02-nfs-configuration.yaml # configuración nfs
ansible-playbook -i hosts 03-k8s-cluster-configuration.yaml # configuración de las máquinas del cluster de kubernetes
ansible-playbook -i hosts 04-k8s-master-configuration.yaml # configuración del master de kubernetes
# Guardar salida del paso 04 output_join_command.stdout_lines. Opciones: 
# (1) Actualizar variable "comando" en "/group_vars/k8s-worker-configuration.yaml" 
# (2) Lanzar ansible-playbook -i hosts 08-k8s-cluster-add-worker.yaml con ese valor --extra-vars "comando='salida del paso 04'"
ansible-playbook -i hosts 05-k8s-cluster-usuario.yaml # creación de un usuario admin para ver el cluster
ansible-playbook -i hosts 06-k8s-master-sdn.yaml # instalación sdn (entre nodos)
ansible-playbook -i hosts 07-k8s-master-ingress.yaml # instalación ingress (fuera http y https)
ansible-playbook -i hosts 08-k8s-worker-configuration.yaml  --extra-vars "comando='salida del paso 04'" # añadir worker al cluster
ansible-playbook -i hosts 09-app-desploy-mysql.yaml # despliegue mysql