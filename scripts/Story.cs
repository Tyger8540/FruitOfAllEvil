using Godot;
using GodotInk;

public partial class Story : VBoxContainer
{
	[Export]
	private InkStory story;
	
	private string text_block = "";
	
	public override void _Ready()
	{
		ContinueStory();
	}

	private void ContinueStory()
	{
		foreach (Node child in GetChildren())
			child.QueueFree();

		//GD.Print(story);
		//InkStory saved_story = story;
		//story.ContinueMaximally();
		//if (story == saved_story)
		//{
			//text_block = "";
			//return;
		//}
		//else
		//{
			//story = saved_story;
		//}
		//text_block = text_block + story.Continue();
		//Label content = new() { Text = text_block };
		Label content = new() { Text = story.Continue() };
		AddChild(content);
		//GD.Print(story.TagsForContentAtPath(content.Text));

		foreach (InkChoice choice in story.CurrentChoices)
		{
			Button button = new() { Text = choice.Text };
			button.Pressed += delegate
			{
				story.ChooseChoiceIndex(choice.Index);
				ContinueStory();
			};
			AddChild(button);
			//GD.Print(button.Position);
		}
	}
}
