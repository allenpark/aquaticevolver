package Creature
{
	public class AECreature
	{
		private var _head:AEHead;
		private var _torso:AETorso;
		private var _tail:AETail;
		
		public function AECreature(head:AEHead, torso:AETorso, tail:AETail)
		{
			_head = head;
			_torso = torso;
			_tail = tail;
			
			//TODO: attach head-torso-tail
		}
	}
}