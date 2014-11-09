def run(command)
  system(command) or raise "RAKE TASK FAILED: #{command}"
end

namespace "test" do
  desc "Run unit tests"
  run "xcodebuild -workspace 'GM Taplist.xcworkspace' -scheme 'GM Taplist' -sdk iphonesimulator clean test"
end

namespace "build" do
  # This would create an ipa but... thats more work
end
