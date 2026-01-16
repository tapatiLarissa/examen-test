# Examen DevSecOps – Application Node.js

## Contexte
Ce projet s’inscrit dans le cadre de l’examen **DevSecOps – Bachelor 3 – Année 2026**.  
L’objectif est de mettre en place une chaîne **CI/CD sécurisée**, de conteneuriser une application **Node.js**, de scanner les images Docker, puis de déployer l’application sur **AWS EC2** à l’aide de **Terraform**.

---

## Architecture globale CI/CD

L’architecture repose sur les composants suivants :

- **GitHub** : hébergement du code source
- **GitHub Actions** : pipeline CI/CD
- **Node.js 18/24** : application backend (API simple)
- **Docker** : conteneurisation de l’application
- **Docker Hub** : registre d’images Docker
- **Trivy** : scan de vulnérabilités des images Docker
- **Terraform** : Infrastructure as Code
- **AWS EC2** : hébergement de l’application
- **Security Groups AWS** : contrôle des accès réseau

---

## Chaîne CI/CD

### 1. Intégration Continue (CI)

La pipeline CI s’exécute automatiquement lors :
- d’un `push` sur les branches `main` ou `develop`
- d’une `pull_request` vers `main` ou `develop`

Étapes exécutées :
1. Checkout du code
2. Installation de Node.js
3. Installation des dépendances (`npm install`)
4. Vérification du code (lint)
5. Exécution des tests (si présents)

---

### 2. Déploiement Continu (CD)

Le déploiement ne s’exécute **que sur la branche `main`**.

Étapes :
1. Build de l’image Docker de l’application Node.js
2. Authentification au registre Docker Hub via GitHub Secrets
3. Push de l’image Docker vers Docker Hub

---

## Sécurité – DevSecOps

### Scan de vulnérabilités avec Trivy

L’outil **Trivy** est intégré à la pipeline CI/CD afin de :
- Scanner l’image Docker construite
- Détecter les vulnérabilités de niveau **HIGH** et **CRITICAL**

Le scan est exécuté **après la construction de l’image Docker**.

Avantages de Trivy :
- Facile à intégrer
- Rapide
- Détection des vulnérabilités OS et applicatives
- Compatible avec CI/CD

---

## Déploiement sur AWS avec Terraform

### Infrastructure créée

Terraform est utilisé pour provisionner automatiquement :

- Une instance **EC2 Ubuntu 22.04 LTS**
- Un **Security Group** autorisant :
  - SSH (port 22)
  - Accès à l’application (port 8080)
- Une **clé SSH** pour l’accès sécurisé
- Installation automatique de Docker
- Lancement du conteneur Node.js depuis Docker Hub

---

### Accès à l’application

Une fois le déploiement terminé, l’application est accessible via :

