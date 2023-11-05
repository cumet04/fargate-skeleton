{
  family: 'fargate-skeleton_{{ must_env `TF_VAR_name` }}-main',
  cpu: '256',
  memory: '512',
  networkMode: 'awsvpc',
  requiresCompatibilities: ['FARGATE'],
  executionRoleArn: '{{ tfstate `output.task_execution_role_arn` }}',

  containerDefinitions: [{
    essential: true,
    image: 'nginx:latest',
    name: 'nginx',
    environment: [
      {
        name: 'hoge',
        value: 'fuga',
      },
    ],
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
