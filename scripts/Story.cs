using Godot;
using GodotInk;

public partial class Story : VBoxContainer
{
	[Export]
	private InkStory story;
	
	public override void _Ready()
	{
		ContinueStory();
	}

	private void ContinueStory()
	{
		foreach (Node child in GetChildren())
			child.QueueFree();

		Label content = new() { Text = story.Continue() };
		AddChild(content);

		foreach (InkChoice choice in story.CurrentChoices)
		{
			Button button = new() { Text = choice.Text };
			button.Pressed += delegate
			{
				story.ChooseChoiceIndex(choice.Index);
				ContinueStory();
			};
			AddChild(button);
			GD.Print(button.Position);
		}
	}
}
