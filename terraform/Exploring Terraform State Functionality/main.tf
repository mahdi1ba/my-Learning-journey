provider "kubernetes" {
  config_path = "~/.kube/config"
}
#deployment of 2 replicas of nginx
#If you are referring to Replica in Kubernetes it means how many pods of the same application should run in cluster.

resource "kubernetes_deployment" "tf-k8s-deployment" {
  metadata {
    name = "tf-k8s-deploy"
    labels = {
      name = "terraform-k8s-deployment"
    }
  }

  spec {
    replicas = 2

    selector {
      match_labels = {
        name = "terraform-k8s-deployment"
      }
    }

    template {
      metadata {
        labels = {
          name = "terraform-k8s-deployment"
        }
      }

      spec {
        container {
          image = "nginx"
          name  = "nginx"

        }
      }
    }
  }
}