{
  region: 'ap-northeast-1',
  cluster: 'fargate-skeleton_{{ must_env `TF_VAR_name` }}',
  service: 'main',
  service_definition: 'ecs-service-def.jsonnet',
  task_definition: 'ecs-task-def.jsonnet',
  timeout: '10m0s',
  plugins: [
    {
      name: 'tfstate',
      config: {
        url: '../.terraform.tfstate',
      },
    },
  ],
}
