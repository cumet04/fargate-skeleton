{
  deploymentConfiguration: {
    maximumPercent: 200,
    minimumHealthyPercent: 0,
  },
  desiredCount: 1,
  launchType: 'FARGATE',
  loadBalancers: [
    {
      containerName: 'app',
      containerPort: 3000,
      targetGroupArn: '{{ tfstate `output.target_group_arn` }}',
    },
  ],
  networkConfiguration: {
    awsvpcConfiguration: {
      assignPublicIp: 'ENABLED',
      securityGroups: [
        '{{ tfstate `output.security_group_id` }}',
      ],
      subnets: [
        '{{ tfstate `output.subnet1_id` }}',
        '{{ tfstate `output.subnet2_id` }}',
      ],
    },
  },
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
