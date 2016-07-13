using UnityEngine;
using System.Collections;

namespace Holojam {
	public class ViveHolojamViewManager : MonoBehaviour {
		public Network.HolojamView ViveHeadset;
		public Network.HolojamView ViveWandLeft;
		public Network.HolojamView ViveWandRight;
		// Use this for initialization
		void Start () {
			
		}
		
		// Update is called once per frame
		void Update () {
			ViveHeadset.RawPosition = ViveHeadset.transform.position;
			ViveHeadset.RawRotation= ViveHeadset.transform.rotation;

			ViveWandLeft.RawPosition = ViveWandLeft.transform.position;
			ViveWandLeft.RawRotation= ViveWandLeft.transform.rotation;

			ViveWandRight.RawPosition = ViveWandRight.transform.position;
			ViveWandRight.RawRotation= ViveWandRight.transform.rotation;
		}

		void Awake () {
			ViveHeadset.Label = "vive";
			ViveWandLeft.Label = "vive_controller_left";
			ViveWandRight.Label = "vive_controller_right";

			ViveHeadset.IsMine = true;
			ViveWandLeft.IsMine = true;
			ViveWandRight.IsMine = true;
		}
	}
}