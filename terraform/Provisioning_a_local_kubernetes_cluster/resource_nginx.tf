resource "kubernetes_deployment" "nginx" {
    metadata {
      name = "scalable-nginx-exemple"
      labels = {
          App = "ScalableNginxExemple"
      }
    }
    spec {
        replicas = 2
        selector {
            match_labels = {
                App = "ScalableNginxExemple"
            }
        }
        template {
            metadata {
                labels = {
                    App = "ScalableNginxExemple"
                }
            }
            spec {
                container {
                    image = "nginx:1.7.8"
                    name = "exemple"
                    port {
                        container_port = 80
                    }
                    resources {
                        limits = {
                            cpu = "0.5"
                            memory = "512Mi"
                        }
                        requests = {
                            cpu = "250m"
                            memory = "50Mi"
                        }
                    }
                }
            }
        }
    }
}