{
  lib,
  aiomisc-pytest,
  aiormq,
  buildPythonPackage,
  docker,
  exceptiongroup,
  fetchFromGitHub,
  pamqp,
  poetry-core,
  pytestCheckHook,
  pythonOlder,
  shortuuid,
  testcontainers,
  wrapt,
  yarl,
}:

buildPythonPackage rec {
  pname = "aio-pika";
  version = "9.5.5";
  pyproject = true;

  disabled = pythonOlder "3.9";

  src = fetchFromGitHub {
    owner = "mosquito";
    repo = "aio-pika";
    tag = version;
    hash = "sha256-Gs01y1VRVgk5i4JI+fqtRo6mOyzBzHM/2hJPVenc+3g=";
  };

  build-system = [ poetry-core ];

  dependencies = [
    aiormq
    exceptiongroup
    yarl
  ];

  nativeCheckInputs = [
    aiomisc-pytest
    docker
    pamqp
    pytestCheckHook
    shortuuid
    testcontainers
    wrapt
  ];

  disabledTests = [
    # Tests attempt to connect to a RabbitMQ server
    "test_connection_interleave"
    "test_connection_happy_eyeballs_delay"
    "test_robust_connection_interleave"
    "test_robust_connection_happy_eyeballs_delay"
  ];

  disabledTestPaths = [
    # Tests attempt to connect to a RabbitMQ server
    "tests/test_amqp.py"
    "tests/test_amqp_robust.py"
    "tests/test_amqp_robust_proxy.py"
    "tests/test_amqps.py"
    "tests/test_master.py"
    "tests/test_memory_leak.py"
    "tests/test_rpc.py"
    "tests/test_types.py"
  ];

  pythonImportsCheck = [ "aio_pika" ];

  meta = with lib; {
    description = "AMQP 0.9 client designed for asyncio and humans";
    homepage = "https://github.com/mosquito/aio-pika";
    changelog = "https://github.com/mosquito/aio-pika/blob/${version}/CHANGELOG.md";
    license = licenses.asl20;
    maintainers = with maintainers; [ emilytrau ];
  };
}
