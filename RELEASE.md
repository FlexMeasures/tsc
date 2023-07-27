# Release Management


## Release policy

FlexMeasures is released with [semantic versioning](https://semver.org/).

We strive for a MINOR release roughly once per month,
and to release PATCH versions as soon as issues are fixed.

## Checklist

This checklist guides you through preparing, testing and documenting a release.


### Preparation steps

- [ ] Decide which commits to main you want to include in the release, and make sure the [corresponding milestone](https://github.com/FlexMeasures/flexmeasures/milestones) is up-to-date and 100% closed (move open issues to the next milestone, if needed)
- [ ] Check if the changes which happened justify the next version number you had in mind. https://semver.org/ has a helpful guide to differentiate between MAJOR, MINOR, PATCH releases:
  1. MAJOR version when you make incompatible API changes,
  2. MINOR version when you add functionality in a backwards compatible manner, and
  3. PATCH version when you make backwards compatible bug fixes.

For a PATCH release:

- [ ] Update the patch release branch:
  - [ ] Backport (locally) to our patch release branch all closed PRs that still have the "Still Needs Manual Backport" label: see https://github.com/FlexMeasures/flexmeasures/pulls?q=is%3Apr+label%3A%22Still+Needs+Manual+Backport%22+is%3Aclosed (one way of doing that is by commenting on the merged PR with "@MeeseeksDev backport to <major>.<minor>.x"
  - [ ] Prepend each commit message with "Backport PR #xxx: " before pushing
  - [ ] Don't forget to remove the label on the GitHub PRs after backporting
- Continue to testing

For a MINOR or MAJOR release:

- [ ] Write a blog post about the added features in Publii. You can copy an earlier post, but pay attention to metadata on the right (Featured image, Tags, SEO).
- [ ] Be sure to work on main: `git checkout main` and `git pull`
- [ ] Test documentation creation: `make update-docs`


### Test steps

- [ ] Run automated tests via `make test`.
- [ ] Create the docker compose stack (this tests building and also creates the Docker image for release):
  - `docker rmi flexmeasures_server flexmeasures_worker`
  - `docker compose build`

For a MINOR or MAJOR release:

- [ ] Run a quick QA to see problems not covered by tests: We'll bring up  [our docker compose stack](https://flexmeasures.readthedocs.io/en/latest/dev/docker-compose.html#seeing-it-work-running-the-toy-tutorial) for this:
  - [ ] `docker compose up`  # already makes a toy account in container
  - [ ] Run the last steps of the tutorial (see link above, we still need to add prices and schedule). You can run `scripts/run-tutorial-in-docker.sh` (in this repo).
  - [ ] Test if a schedule was made in the CLI
  - [ ] Bonus (MAJOR release): Also check with `--as-job`, as that touches different code. Use `docker exec -it flexmeasures-worker-1 bash` here, then create schedule like in the tutorial.
  - [ ] Do a quick UI test: log in toy-user, select battery asset, view schedule
  - Run an API test (TODO, maybe use a script to get the tutorial data or add something as well)


### Release steps

- [ ] Be sure to work on main: `git checkout main` and `git pull`
- [ ] Update change logs with a commit described with "Prepare changelogs for v<major>.<minor>.<patch> release"
  - [ ] Insert today's date into `documentation/changelog.rst`
  - [ ] (MINOR or MAJOR) Get the blog post's slug (by copying in Publii, see right side under "SEO") and link to the post from the changelog (copy note from earlier versions).	
  - [ ] Look at `documentation/cli/change_log.rst` to see if we made changes there. Update the date.
  - [ ] Likewise, look at `documentation/api/change_log.rst`
- [ ] Update dependencies: 
  - [ ] `make freeze-deps`
- [ ] Commit & push
  - local changes (e.g. from the change log updates), e.g.: `git commit -S -sam "changelog & deps updates for v<major>.<minor>"`
  - `git push`
  - (PATCH) `git checkout` the patch release branch, backport the change log updates, and `git push` again
  - Add the version tag: `git tag -s -a v<major>.<minor>.<patch> -m ""`
  - `git push --tags` 
- [ ] Create a release on GitHub based on the new tag  (you can copy the title from your blog post and also paste the change log notes in there; code assets are added automatically)
- [ ] (MINOR or MAJOR) Publish the blog post in Publii ("Sync your website")
- [ ] Check if the documentation builds on [readthedocs.org](https://readthedocs.org/projects/flexmeasures/builds/) (login via Github)
- [ ] Release to Pypi
  - Run `./to_pypi.sh`  # Credentials in Seita's keepass store
  - Test (in some fresh context) if pip installs the fresh version:
    - `python3 -m venv testing-fm-latest`
    - `source testing-fm-latest/bin/activate`
    - `pip install --upgrade flexmeasures`  # should download & install new version
    - `deactivate && rm -rf testing-fm-latest`
- [ ] Mention the release (with link to the blog post) on:
  - [ ] the @flexmeasures Twitter account
  - [ ] the @flexmeasures@fosstodon.org Mastodon account
  - [ ] the FlexMeasures mailing list
  - [ ] the #flexmeasures channel on LF Energy Slack
  - [ ] other suitable social media accounts of yours
- [ ] (MINOR or MAJOR) Prepare structure for next release cycle
  - [ ] Make a new patch release branch for backporting commits with `git branch <major>.<minor>.x` (MINOR) or `git branch <major>.0.x` (MAJOR) 
  - [ ] Make an empty commit on main (not on the newly created patch release branch) with `git commit --allow-empty -S -sm "Start <major>.<minor+1>.0"` (MINOR) or `git commit --allow-empty -S -sm "Start <major+1>.0.0"` (MAJOR)
  - [ ] `git push`
  - [ ] Tag the new commit with `v<major>.<minor+1>.0.dev0` (MINOR) or `v<major+1>.0.0.dev0` (MAJOR)
  - [ ] `git push --tags`
- [ ] Create a new version of our Docker image:
  - [ ] Check `docker images` (CREATED column) to make sure the `flexmeasures-server` image is the one you just built (under "Test steps") 
  - [ ] `docker tag flexmeasures-server lfenergy/flexmeasures:v<major>.<minor>.<patch>`
  - [ ] `docker tag lfenergy/flexmeasures:v<major>.<minor> lfenergy/flexmeasures:latest`
  - [ ] `docker login -u flexmeasures`  # Credentials for the Docker account are in Seita's keepass store. When using Docker Desktop (maybe for all Docker demons), you need a GPG key to use the Linux pass-store (https://docs.docker.com/desktop/get-started/#sign-in-to-docker-desktop)
  - `docker push lfenergy/flexmeasures:v<major>.<minor>.<patch>`
  - `docker push lfenergy/flexmeasures:latest`
  - Check on https://hub.docker.com/r/lfenergy/flexmeasures/tags
- [ ] Close the current milestone and make a new milestone on https://github.com/FlexMeasures/flexmeasures/milestones
- [ ] (MINOR or MAJOR) Update `documentation/changelog.rst` to avoid wasting time on change log merge conflicts later:
  - Add a placeholder for the next patch release
  - Add a placeholder for the next minor release
  - Commit the placeholder(s)
- [ ] (MINOR or MAJOR) Upgrade dependencies now, so they are well-tested when the next version is released: `make upgrade-deps`. Probably good to release this change in a PR to discuss, of course especially if `make test` is not successful. Also, this is a good moment to try removing conflict-related version limits (app.in protects test.in, which protects dev.in) 
  
