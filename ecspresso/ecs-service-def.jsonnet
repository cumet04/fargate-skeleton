{
  deploymentConfiguration: {
    maximumPercent: 200,
    minimumHealthyPercent: 0,
  },
  desiredCount: 1,
  launchType: 'FARGATE',
  networkConfiguration: {
    awsvpcConfiguration: {
      assignPublicIp: 'ENABLED',
      securityGroups: [
        '{{ tfstate `output.security_group_id` }}',
      ],
      subnets: [
        '{{ tfstate `output.subnet_id` }}',
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
