fvm flutter test --coverage --test-randomize-ordering-seed random
# Exclude files from the coverage
lcov --remove coverage/lcov.info 'lib/routes/*' -o coverage/lcov.info
# Generate Coverage Report
genhtml coverage/lcov.info -o coverage/html