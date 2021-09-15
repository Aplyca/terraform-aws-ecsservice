# Terraform AWS ECS Service module

Deploy al necessary resources for ECS apps

# Example of service

```HCL
module "my_service" {
  source  = "Aplyca/ecsdeploy/aws"
  version = "0.1.1"

  cluster = "MYCLUSTER"
  desired = 1

  balancer = {
    name = "MyALB"
    path = "/healthcheck"
    healthy_threshold = "2"
    unhealthy_threshold = "3"
    interval = "30"
    timeout = "5"
    protocol = "HTTP"
  }

  repositories = [{
    name = "App"
    mutability = "MUTABLE"
    scan = true
  }]

  task_file = "task.json.tpl"
  task_vars = {
    app_tag = "master"
    app_name = "MyApp"
    service = "MyService"
    env = "Production"
    container = "Web"
    container_port = "80"
  }

  # Parameter value is not supported here. You should set the value manually from the AWS console.
  parameters = [{
    name = "DATABASE_PASSWORD"
    description = "Description of this parameter"
  }]

  volumes = [{
    name      = "MyApp-Storage"
    host_path = "/mnt/myapp-storage"
  }]
}
```

Example of a Task definition

```JSON
[{
    "name": "${container}",
    "portMappings": [{
        "hostPort": ${container_port},
        "protocol": "tcp",
        "containerPort": ${container_port}
    }],
    "logConfiguration": {
      "logDriver": "awslogs",
      "options": {
        "awslogs-group": "${log_group}",
        "awslogs-region": "${region}",
        "awslogs-stream-prefix": "${service}"
      }
    },
    "image": "${App}:${app_tag}"
  }
]
```
Example of service using capacity providers
```HCL
module "my_service" {
  source = "github.com/Aplyca/terraform-aws-ecsservice"
  
  # Others settings
  
  # Example to add capacity providers
  launch_type = null
  capacity_provider_strategies = [
    {
      # base = 0
      # weight = 1
      capacity_provider = aws_ecs_capacity_provider.this.name
    }
  ]
  
  # Example to add a custom placement strategies 
  ordered_placement_strategies = [
    {
      field = "attribute:ecs.availability-zone"
      type  = "spread"
    },
    {
      field = "memory"
      type  = "binpack"
    }
  ]
  
}
```

Example of One Task Per Host placement strategy and constrains
```HCL
module "my_service" {
  source = "github.com/Aplyca/terraform-aws-ecsservice"
  
  # Others settings

  ## One Task Per Host

  placement_constraints = {
    type  = "distinctInstance"
    expression = ""
  }

  ordered_placement_strategies = []
```

Example of Rolling update deployment options
```HCL
module "my_service" {
  source = "github.com/Aplyca/terraform-aws-ecsservice"
  
  # Others settings

  ## Rolling update deployment options

  deployment_maximum_percent = 100
  deployment_minimum_healthy_percent = 50
```
