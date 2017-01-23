node("docker") {
  checkout scm
  sh "git rev-parse HEAD > .git/commit-id"
  def commit_id = readFile('.git/commit-id').trim()
  println commit_id

  stage("build") {
    sh "cd build && source ./build"
  }
}