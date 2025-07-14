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
- Work in your `flexmeasures` folder (the repo) and activate your virtual environment (e.g. for building the code to Pypi)
- Be sure you only work on FlexMeasures core. The `FLEXMEASURES_PLUGINS` setting should not be set.

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
  - `docker rm flexmeasures-server-1 flexmeasures-worker-1; docker rmi flexmeasures-server flexmeasures-worker`  (might need a `docker compose down` if you've built earlier)
  - `docker compose build`

For a MINOR or MAJOR release:

- [ ] Run a quick QA to see problems not covered by tests: We'll bring up [our docker compose stack](https://flexmeasures.readthedocs.io/en/latest/dev/docker-compose.html#seeing-it-work-running-the-toy-tutorial) for this:
  - [ ] `docker compose up`  # already makes a toy account in container
  - [ ] Run the last steps of the tutorial (see link above, we still need to add prices and schedule). You can run `../tsc/tsc/scripts/run-tutorial-in-docker.sh` (in this repo).
  - [ ] Validate that a schedule was made in the CLI (the above script should do so)
  - [ ] (MAJOR release) Also check with `--as-job`, as that touches different code:
    - `TOMORROW=$(date --date="next day" '+%Y-%m-%d'); docker exec -it flexmeasures-worker-1 bash -c "flexmeasures add schedule for-storage --sensor 2 --consumption-price-sensor 1 --start ${TOMORROW}T07:00+01:00 --duration PT12H --soc-at-start 50% --roundtrip-efficiency 90% --as-job"`
    - `docker logs flexmeasures-worker-1`  # this should tell you if schedule creation went well, e.g. "Job 0b0bf442-799b-47e0-b6d7-6ac1b732bde9 made schedule"
  - [ ] Do a quick UI test: log in toy-user, select battery asset, view schedule
  - Run an API test (TODO, maybe use a script to get the tutorial data or add something as well)


### Release steps

- [ ] Be sure to work on main: `git checkout main` and `git pull`
- [ ] Update change logs
  - [ ] Insert today's date into `documentation/changelog.rst`
  - [ ] (MINOR or MAJOR) Get the blog post's slug (by copying in Publii, see right side under "SEO") and link to the post from the changelog (copy note from earlier versions).	
  - [ ] Look at `documentation/cli/change_log.rst` to see if we made changes there. Update the date.
  - [ ] Likewise, look at `documentation/api/change_log.rst`
- [ ] (MINOR or MAJOR) Update dependencies (across Python versions): 
  - [ ] `cd ci; ./update-packages.sh; cd ..`
- [ ] Commit & push
  - local changes (e.g. from the change log updates), e.g.: `git commit -S -sam "changelog & deps updates for v<major>.<minor>"`
  - `git push`
  - (PATCH) `git checkout` the patch release branch, backport the change log updates, and `git push` again
  - Add the version tag: `git tag -s -a v<major>.<minor>.<patch> -m ""`
  - `git push --tags`
- [ ] Check if the documentation builds on [readthedocs.org](https://readthedocs.org/projects/flexmeasures/builds/) (login via Github)
- [ ] Create [a release on GitHub](https://github.com/FlexMeasures/flexmeasures/releases) based on the new tag (you can copy the title from your blog post and also paste the change log notes in there; the "Generate release notes" button is also cool; code assets are added automatically)
- [ ] (MINOR or MAJOR) Publish the blog post in Publii ("Sync your website") - if you need a Github token, you can generate one [like this](https://github.com/settings/tokens/new?scopes=public_repo,repo_deployment&description=Token%20for%20Deployment%20to%20GitHub%20Pages). Other Server settings for [Publii under Github Pages](https://getpublii.com/docs/host-static-website-github-pages.html): "Website URL":"flexmeasures.io", "API Server": "api.github.com", "Username": "FlexMeasures", "Repository": "website".
- [ ] Release to Pypi
  - Run `./to_pypi.sh`  # Credentials in Seita's keepass store (in the "PyPi" card's description), use `__token__` as username and the access token as password
  - Test (in some fresh context) if pip installs the fresh version:
    - `python3 -m venv testing-fm-latest; source testing-fm-latest/bin/activate`
    - `pip install --upgrade flexmeasures`  # should download & install new version
    - `python -c "from flexmeasures import __version__; print(__version__)"` # should print your new version
    - `deactivate && rm -rf testing-fm-latest`
- [ ] Release to Docker Hub:
  - [ ] Check `docker images` (CREATED column) to make sure the `flexmeasures-server` image is the one you just built (under "Test steps")
  - [ ] Re-build, because we want the new git version tag to be part of it: `docker compose build`
  - [ ] `docker tag flexmeasures-server lfenergy/flexmeasures:v<major>.<minor>.<patch>`
  - [ ] `docker tag lfenergy/flexmeasures:v<major>.<minor>.<patch> lfenergy/flexmeasures:latest`
  - [ ] `docker login -u flexmeasures`  # Credentials for the Docker account are in Seita's keepass store. When using Docker Desktop (maybe for all Docker demons), you need a GPG key to use the Linux pass-store (https://docs.docker.com/desktop/get-started/#sign-in-to-docker-desktop)
  - `docker push lfenergy/flexmeasures:v<major>.<minor>.<patch>`
  - `docker push lfenergy/flexmeasures:latest`
  - Check on https://hub.docker.com/r/lfenergy/flexmeasures/tags
- [ ] Mention the release (with link to the blog post) on:
  - [ ] the @flexmeasures Twitter account
  - [ ] the @flexmeasures@fosstodon.org Mastodon account
  - [ ] the FlexMeasures mailing list
  - [ ] the #flexmeasures channel on LF Energy Slack
  - [ ] other suitable social media accounts of yours
- [ ] (MINOR or MAJOR) Prepare structure for next release cycle
  - [ ] Make a new patch release branch for backporting commits with `git branch <major>.<minor>.x` (MINOR) or `git branch <major>.0.x` (MAJOR) 
  - [ ] `git checkout <your-branch>`
  - [ ] Make an empty commit on main (not on the newly created patch release branch) with `git commit --allow-empty -S -sm "Start <major>.<minor+1>.0"` (MINOR) or `git commit --allow-empty -S -sm "Start <major+1>.0.0"` (MAJOR)
  - [ ] `git push`
  - [ ] Tag the new commit with `git tag v<major>.<minor+1>.0.dev0` (MINOR) or `git tag v<major+1>.0.0.dev0` (MAJOR)
  - [ ] `git push --tags`
  - [ ] `git checkout main`
- [ ] Close the current milestone and make a new milestone on https://github.com/FlexMeasures/flexmeasures/milestones (you can move over not-closed issues manually)
- [ ] (MINOR or MAJOR) Update `documentation/changelog.rst` to avoid wasting time on change log merge conflicts later:
  - Add a placeholder for the next patch release
  - Add a placeholder for the next minor release
  - Commit the placeholder(s)
- [ ] (MINOR or MAJOR) Upgrade dependencies now, so they are well-tested when the next version is released: `make upgrade-deps`. Probably good to release this change in a PR to discuss, of course especially if `make test` is not successful. Also, this is a good moment to try removing conflict-related version limits (app.in protects test.in, which protects dev.in) 
  - [ ] `cd ci; ./update-packages.sh upgrade; cd ..`
  - [ ] `cp requirements/3.11/app.txt requirements.txt`  # we keep that around for Snyk (add note in the header) at the moment, maybe it can become a symbolic link one day?
  - [ ] `git diff | vim -`  # manually inspect which version jumps are major
  - [ ] `git checkout -b chore/upgrade-dependencies-for-v<major>.<minor+1>`  # this branch will be the basis for the PR
  - [ ] `make install-for-dev`
  - [ ] `pytest -x`  # if this goes well, we can rather quickly merge the PR, if it fails, we have work to do
