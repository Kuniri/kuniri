# Configuration module keep all the constants for make the system works.
# | __Configure__ | __Description__ |
# |---|---|
# | Monitor  | Types of monitoring available. |
# | Language | Languages available. |
# | Watchdog | Types of watchdog. |
module Configuration
  # Configuration for the monitor available.
  class Monitor_Available
    public
      MONITORS = ["uml", "traceability"] #List with monitors types.
  end
end
