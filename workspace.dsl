workspace "EOSC Data Commons" "EOSC Data Commons Architecture" {


  model {
    u = person "EOSC User"
    eodcservice = softwareSystem "EOSC Data Commons Services" {
      mm = container "EOSC Matchmaker" {
        crawler = component "Crawler"
	ui = component "User Interface" {
          tags "UI"
	}
	repoAPI = component "Repository API Facade"
	wh_db = component "Metadata Warehouse DB" {
		tags "Database"
	}
	wh_se = component "Metadata Warehouse Search Engine" {
		tags "Database"
	}
	se = component "Search Engine"
	toolscatalogue = component "Catalogue of Tools"
    	packager = component "Packager"    
	fairness = component "FAIRness service"
	enrichment = component "Enrichment service"
      }
      player = container "EOSC Data Player" {
        dispatcher = component "Dispatcher"
        dep_tools = component "Deployment tools"
	data_tools = component "Data access tools"
      }
    }

    repo = softwareSystem "Data Repository" {
      tags "External"
      tags "Database"
    }
    toolrepo = softwareSystem "Tool Repository" {
      tags "External"
      tags "Database"
    }
    compute = softwareSystem "Execution Platform/VRE" {
      tags "External"
    }

    u -> ui "Uses"
    ui -> repoAPI "Gets files metadata"
    ui -> se "Searches"
    ui -> packager "Get Platform-ready package"
    ui -> toolscatalogue "Get matching tools"
    ui -> dispatcher "Request Dispatch"
    toolscatalogue -> toolrepo "Harvests"
    crawler -> repo "Harvests"
    crawler -> wh_db "Populates"
    ui -> wh_se "Searchers"
    wh_se -> wh_db "Indexes"
    fairness -> wh_db "Adds FAIRness score"
    enrichment -> wh_db "Enriches metadata"
    dispatcher -> dep_tools "Request deployment of compute environment (VRE)"
    dispatcher -> data_tools "Request data at analysis environment"
    dispatcher -> compute "Deploys analysis"
    data_tools -> compute "Manages data"
    dep_tools -> compute "Deploys VRE"
  }

  views {
    systemLandscape edc "Diagram3" {
    include *
      autolayout lr
  }
    systemContext eodcservice "Diagram1" {
      include *
      autolayout lr
    }

  container eodcservice "EODCService" {
    include *
    autolayout lr
  }

 component mm {
    include *
    autolayout tb 
}

 component  player {
    include *
    autolayout lr
}


    styles {
    /*
      element "Element" {
        color #ffffff
      }
      */
      element "Person" {
        background #d34407
        shape person
      }
      /*
      element "Software System" {
        background #f86628
      }
      element "Container" {
        background #f88728
      }
      */
      element "Database" {
        shape cylinder
      }
/*
    element "External" {
        background #48664f
    }
  */
    element "UI" {
       shape WebBrowser
    }
    }
  }

  configuration {
    scope softwaresystem
  }

}
