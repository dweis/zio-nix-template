name := "zio-nix-template"
organization := "com.example"

val scala3Version = "3.4.1"

lazy val root = project
  .in(file("."))
  .settings(
    name := "zio-nix-template",
    version := "0.1.0-SNAPSHOT",
    scalaVersion := scala3Version,
    libraryDependencies ++= Seq(
      "dev.zio" %% "zio" % "2.0.21",
      "org.scalameta" %% "munit" % "0.7.29" % Test
    )
  )
