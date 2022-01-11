variable "cluster" {
  description = "ECS cluster name"
  default = ""
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  default     = {}
}

variable "task_vars" {
  description = "Container task definition vars. For cpu and memory see accepted values: https://docs.aws.amazon.com/AmazonECS/latest/developerguide/task-cpu-memory-error.html"
  default = {
    app_tag = "master"
    app_name = ""
    service = ""
    env = ""
    container = ""
    container_port = ""
    task_definition = ""
    file = ""
  }
}

variable "balancer" {
  type = map
  description = "Balancer configurations"
  default = {
    name = ""
    path = "/"
    healthy_threshold = "5"
    unhealthy_threshold = "2"
    interval = "30"
    timeout = "5"     
    protocol = "HTTP"
  }
}

variable "volumes" {
  type = list
  description = "List of Volumes used by the service"
  default = []
}

variable "desired" {
  description = "Desired count of tasks in service"
  default = 1
}

variable "grace_period" {
  description = "health_check_grace_period_seconds"
  default = 0
} 

variable "repositories" {
  description = "Images repositories"
  default = []
}

variable "compatibilities" {
  description = "Requires compatibilities"
  default = []
}

variable "network_mode" {
  description = "The valid values are none, bridge, awsvpc, and host"
  default = "bridge"
}

variable "target_type" {
  description = "Target Type for Target Group"
  default = "instance"
}

variable "launch_type" {
  description = "Launch type"
  default = "EC2"
}

variable "subnets" {
  type = list
  default = []
  description = "Used for Networking in Service Discovery"
}

variable "placement_constraints" {
  description = "(Optional) A set of rules that are taken during task placement"
  type        = "list"
  default = []
}

variable "parameters" {
  type = list
  description = "List of parameters used by the service form Parameters Store"
  default = []
}

variable "discovery" {
  type = map
  description = "Service discovery description"
  default = {
    namespace = ""
    dns_ttl = 10
    dns_type = "A"
    routing_policy = "MULTIVALUE"     
    healthcheck_failure = 10
    failure_threshold = ""
  }
}

variable "inbound_security_groups" {
  type = list
  description = "Inbound security groups for awsvpc"
  default = []
}

variable "listener_rules" {
  type = list
  description = "Listener rules for ALB listener"
  default = []
}

variable "outbound_security_groups" {
  type = list
  description = "Outbound security groups for Service"
  default = []
}

variable "scheduled_tasks" {
  type = list
  description = "Create scheduled tasks related to this service"
  default = []
}

variable "log_retention" {
  description = "Log retention in days, 0 for unlimmited"
  default = 0
}

variable "capacity_provider_strategies" {
  type = list
  default = []
}

variable "ordered_placement_strategies" {
  type = list
  default = [
    {
      type  = "spread"
      field = "host"
    }
  ]
}

variable "balancer_deregistration_delay" {
  description = "Target Group Deregistration delay"
  default = 3
}

variable "deployment_maximum_percent" {
  description = "deployment_maximum_percent"
  default = null
}

variable "deployment_minimum_healthy_percent" {
  description = "deployment_minimum_healthy_percent"
  default = null
}

variable "aws_lb_listener_rule_actions" {
  description = "aws lb listener rule actions"
  type = list
  default = [
    {
      type = "forward"
    }
  ]
}
