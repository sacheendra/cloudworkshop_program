module.exports = {
  apps: [{
    name: 'API',
    script: './bin/www',
    env: {
      NODE_ENV: 'development'
    },
    env_production: {
      NODE_ENV: 'production',
      PORT: 80
    }
  }]
};