using UnityEngine;
using System.Collections;

namespace Holojam {
	public class ViveHolojamViewManager : MonoBehaviour {
		public Network.HolojamView ViveHeadset;
		public Network.HolojamView ViveWandLeft;
		public Network.HolojamView ViveWandRight;
		// Use this for initialization
		void Start () {
			ViveHeadset.Label = "vive";
			ViveWandLeft.Label = "vive_controller_left";
			ViveWandRight.Label = "vive_controller_right";

			ViveHeadset.IsMine = true;
			ViveWandLeft.IsMine = true;
			ViveWandRight.IsMine = true;
		}
		
		// Update is called once per frame
		void Update () {
		
		}
	}
}