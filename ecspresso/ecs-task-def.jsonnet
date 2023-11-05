{
  family: 'fargate-skeleton_{{ must_env `TF_VAR_name` }}-main',
  cpu: '256',
  memory: '512',
  networkMode: 'awsvpc',
  requiresCompatibilities: ['FARGATE'],
  executionRoleArn: '{{ tfstate `output.task_execution_role_arn` }}',

  containerDefinitions: [{
    essential: true,
    image: '{{ tfstate `output.repository_url` }}:latest',
    name: 'app',
    environment: [
      {
        name: 'USERNAME',
        value: 'hoge',
      },
      {
        name: 'APP_ENV',
        value: 'production',
      },
      {
        name: 'PORT',
        value: '3000',
      },
    ],
    portMappings: [{ containerPort: 3000 }],
    logConfiguration: {
      logDriver: 'awslogs',
      options: {
        'awslogs-group': '{{ tfstate `output.log_group_name` }}',
        'awslogs-region': 'ap-northeast-1',
        'awslogs-stream-prefix': 'app',
      },
    },
  }],

  tags: [
    {
      key: 'iacName',
      value: '{{ must_env `TF_VAR_name` }}',
    },
    {
      key: 'iacRepo',
      value: 'github.com/cumet04/fargate-skeleton',
    },
  ],
}
