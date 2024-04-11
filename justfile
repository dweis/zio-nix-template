default:
    @just --list

run:
    sbt run

# Auto-format the source tree
fmt:
    treefmt
