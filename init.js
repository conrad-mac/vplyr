var initVoice = function() {
if (annyang) {
        
    // Set default values
    Shiny.onInputChange('loadTable', null);
    Shiny.onInputChange('showPlot', null);
    Shiny.onInputChange('filterVar', null);
    Shiny.onInputChange('filterVal', null);
    Shiny.onInputChange('selectVar', null);
    Shiny.onInputChange('plotVar', null);

  var commands = {
    'load data': function(){
        Shiny.onInputChange('loadTable', 1);
    },
    
    'hide data': function(){
        Shiny.onInputChange('loadTable', null);
    },
    
    'show plot window': function(){
        Shiny.onInputChange('showPlot', 1);
    },
    
    'filter variable :variable': function(variable){
        Shiny.onInputChange('filterVar', variable.toLowerCase());
    },
    
    'filter value :value': function(value){
        Shiny.onInputChange('filterVal', value.toLowerCase());
    },
    
    'select variable :variable': function(variable){
        Shiny.onInputChange('selectVar', variable.toLowerCase());
    },
    
    'plot variable :variable': function(variable){
        Shiny.onInputChange('plotVar', variable.toLowerCase());
    },
    
    'show list': showModal,
    
    'hide list': hideModal,
    
    'reset': function(){
        Shiny.onInputChange('loadTable', null);
        Shiny.onInputChange('showPlot', null);
        Shiny.onInputChange('filterVar', null);
        Shiny.onInputChange('filterVal', null);
        Shiny.onInputChange('selectVar', null);
        Shiny.onInputChange('plotVar', null);
        hideModal();
    }
  };

  annyang.addCommands(commands);
  
  annyang.addCallback('resultMatch', function(userSaid, commandText, phrases) {
    //console.log(userSaid); // sample output: 'hello'
    //console.log(commandText); // sample output: 'hello (there)'
    //console.log(phrases); // sample output: ['hello', 'halo', 'yellow', 'polo', 'hello kitty']
    //$(".userSpeech").html("You said: " + phrases[0] +".");
    $(".userSpeech").html('<i class="fa fa-fw fa-commenting"></i> You said "' + userSaid +'".');
  });

  annyang.addCallback('resultNoMatch', function(phrases) {
    //console.log("I think the user said: ", phrases[0]);
    //console.log("But then again, it could be any of the following: ", phrases);
    $(".userSpeech").html('<i class="fa fa-fw fa-commenting"></i>Oops, it sounds like you said "' +
    phrases[0] + '". Please try again or say "show list" for more options.');
    //$(".userSpeech").html("But then again, it could be any of the following: " + phrases);
  });

  annyang.setLanguage('en-NZ');
  annyang.start();
  }
};

var showModal = function() {
   $('#commands_modal').modal('show');
};
var hideModal = function() {
   $('#commands_modal').modal('hide');
};

$(function() {
  setTimeout(initVoice, 10);
});