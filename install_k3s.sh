#!/bin/bash
curl -sfL https://get.k3s.io | sh -
sudo kubectl get nodes
sudo systemctl status k3s
sudo systemctl restart k3s
