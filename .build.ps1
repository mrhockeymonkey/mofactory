
Task . BuildWorker

Task 'BuildWorker' {
    docker build -f mofactory.worker/Dockerfile . -t mofactory/worker:dev
    docker run
}