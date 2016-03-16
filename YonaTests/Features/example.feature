Feature: testing if VPN starts
# This is a free text description as an inline documentation for your features, you can omit it if you want.
# However, it is advisable to describe your features well.

# First scenario is the scenario name, which will also appear in a proper format in Xcode test navigator
Scenario: When I press the button the VPN starts

    # This is the first step in the scenario
    # Also noteworthy; a "Given" step should be treated as the step that defines the app state before going into the rest of the scenario
    # Or consider it as a precondition for the scenario;
    # For example if the user must be logged in to post a comment, then you should say something like "Given the user is logged in" as your Given step.
    Given the VPN has not started

    # The grammar being used is completely defined by you and your QA team; it is up to you to find the best way to define your functionality.
    # Only keep in mind that every step must start with "Given", "When", "Then", "And", or "But".
    When I press the button
    Then the VPN will start