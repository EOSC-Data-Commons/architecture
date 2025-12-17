workspace "EOSC Data Commons" "EOSC Data Commons Architecture" {
  model {
    u = person "EOSC Researcher"

    eodcservice = softwareSystem "EOSC Data Commons Services" {
      /*
       * EOSC Matchmaker
       */
      mm = container "EOSC Matchmaker" {
        crawler = component "Crawlers"
        ui = component "User Interface" {
          tags "UI"
        }
        file_met = component "File Metadata Harvester"
        tools_reg = component "Tools Registry"
        type_reg = component "Type Registry"
        wh_db = component "Metadata Warehouse" {
          tags "Database"
        }
        se = component "Data Commons Search"
        packager = component "Request Packager"
        fairness = component "FAIR Assessment Toolkit"
      }

      /*
       * EOSC Data Player
       */
      player = container "EOSC Data Player" {
        dispatcher = component "Dispatcher"
        dep_tools = component "Deployment tools"
        data_tools = component "Data access tools"
        engine = component "Compute Engines"
      }
    }

    /* External systems */

    llm = softwareSystem "LLM Inference Server" {
      tags "External"
    }
    repo = softwareSystem "Data Repository" {
      tags "External"
      tags "Database"
    }
    toolrepo = softwareSystem "Tool Repository" {
      tags "External"
      tags "Database"
    }
    compute = softwareSystem "Compute Platform" {
      tags "External"
    }
    ext_vre = softwareSystem "VRE" {
      tags "External"
    }

    /*
     * Relationships
     */
    u -> ui "Searches and request deployments"
    ui -> se "Searches"
    se -> wh_db "Searchers"
    ui -> packager "Get Platform-ready package"
    ui -> tools_reg "Get matching tools"
    packager -> dispatcher "Request Dispatch"
    type_reg -> wh_db "Indexed on"
    se -> llm "LLM inference request"
    tools_reg -> toolrepo "Harvests data from"
    crawler -> repo "Harvests data from"
    file_met -> repo "Harvests data from"
    file_met -> wh_db "Serves as file metadata information for"
    tools_reg -> wh_db "Matches tools with data"
    tools_reg -> packager "Get tool information"
    file_met -> type_reg "Sends data to"
    crawler -> wh_db "Populates"
    fairness -> wh_db "Adds FAIRness score"
    engine -> dep_tools "Request deployment of compute environment (VRE)"
    dispatcher -> data_tools "Request data at analysis environment"
    dep_tools -> compute "Deployment of analytics/VREs"
    engine -> ext_vre "Deployment of analytics"
    engine -> compute "Deployment of analytics"
    ext_vre -> dispatcher "Request dispatch"
    ext_vre -> se "Dataset discovery and matching with tools"
    dispatcher -> engine "Submit workload"
    ext_vre -> compute "Runs on"
    data_tools -> compute "Manages data"
    data_tools -> ext_vre "Manages data"
  }

  views {
    systemLandscape edc "SystemLandscape" {
      include *
      autolayout lr
    }
    systemContext eodcservice "Context" {
      include *
    }
    container eodcservice "EDCServices" {
      include *
    }
    component mm {
      include *
      /* to not overload the diagram */
      exclude ext_vre
    }
    component  player {
      include *
    }


    /* some fancier looks for the diagrams */
    styles {
      element "Element" {
        background #3E6DB9
        color #ffffff
        shape roundedbox
        strokeWidth 4
      }
      element "Person" {
        background #284477
        shape person
      }
      element "Database" {
        shape cylinder
      }
      element "External" {
        background #979797
      }
      element "UI" {
        shape WebBrowser
      }
      relationship "Relationship" {
        thickness 3
      }
      element "Boundary" {
        strokeWidth 3
      }
    }
  }

  configuration {
    scope softwaresystem
  }
}
