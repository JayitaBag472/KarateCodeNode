function fn() {

  var env = karate.env; // get system property 'karate.env'

  karate.log('karate.env system property was:', env);

  if (!env) {

    env = 'dev';

  }

  var config = {
    env: env,
    myVarName: 'hello karate',
    baseUrl: 'https://gorest.co.in',
    tokenID: 'b2510089bc7dd87dd1d1d76cb14248f821a794f56e4c43ee3afc61a0a9db1ff9',
    path: '/public/v1/users/'
  }

  if (env == 'dev') {

    // customize

    // e.g. config.foo = 'bar';

  } else if (env == 'e2e') {

    // customize

  }

  return config;

}