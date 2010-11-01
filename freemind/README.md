Freemind Tools
==============

This package contains these freemind tools:

- convert from freemind format (.mm) to text (.yaml)
- convert from text (.yaml) to freemind format (.mm)

You can prove to yourself that it works for your version by roundtripping by piping from one to the other.


    $ruby freemind-to-text.rb mind.mm
    ---
    - x:
      - Projects:
        - Tactics v2:
          - redesign
        - Hamper
        - Framer:
          - Brightness
        - Spikes:
    ...snipped...
