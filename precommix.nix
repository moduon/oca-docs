# Get precommix from separate location, synced with last template update
import (builtins.fetchGit {
  url = "https://gitlab.com/moduon/precommix.git";
  ref = "main";
  rev = "4ecd81a220fb4a7df9940191a97bd78905fcf026";
})
