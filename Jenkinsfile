node("docker") {
  git url: "git@github.com:kebetsi/pryv-packaging.git", credentialsId: 'kschiess'
  sh "git rev-parse HEAD > .git/commit-id"
  def commit_id = readFile('.git/commit-id').trim()
  println commit_id

  stage "build" {
    sh "cd build && ./build"
  }
}