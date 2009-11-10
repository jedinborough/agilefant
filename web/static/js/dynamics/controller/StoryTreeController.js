/**
 * Story tree controller.
 * 
 * Note: currently works only for project
 * 
 * @constructor
 * @base CommonController
 * @param {DOMElement} element DOM parent node for the story table. 
 */
var StoryTreeController = function StoryTreeController(id, element) {
  this.id = id;
  this.element = element;
  this.init();
  this._initializeTree();
};
StoryTreeController.prototype = new CommonController();


StoryTreeController.prototype.refresh = function() {
  $(this.element).load("ajax/getProjectStoryTree.action", {projectId: this.id});
};

/**
 * Initializes the tree.
 * 
 * Will send an ajax request.
 */
StoryTreeController.prototype._initializeTree = function() {
  
  $(this.element).find('li > span').live('click', function() {
    var id = $(this).parent().attr('storyid');
    
    var model = ModelFactory.getOrRetrieveObject(
        ModelFactory.types.story,
        id,
        function(type, id, object) {
          var dialog = new StoryInfoDialog(object);
        },
        function(xhr, status, error) {
          MessageDisplay.Error('Story cannot be loaded', xhr);
        });
  });
};


