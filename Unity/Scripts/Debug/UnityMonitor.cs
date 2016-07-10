using UnityEngine;
using System.Collections;
using System;
using UnityEditorInternal;

/* **************************************************************************
 * CLASS: PerformanceMeasurements
 * Derived from FPS COUNTER
 * *************************************************************************/

[RequireComponent(typeof(GUIText))]
public class UnityMonitor: MonoBehaviour {

	/* Public Variables */
	public string host = "127.0.0.1";
	public int port = 3333;
	public float frequency = 0.5f;


	// Key buffer
	int buffersize = 100;
	float[] data;
	float maxValue;
	int counter;

	string[] statisticProperties;

	static 


	public int FramesPerSec { get; protected set; }

	private void Start() {
		Init();
		StartCoroutine(MFRAME());
	}

	/*
	 * EVENT: MFRAME
	 */
	private IEnumerator MFRAME() {
		for(;;){

			// Capture frame-per-second
			int lastFrameCount = Time.frameCount;
			float lastTime = Time.realtimeSinceStartup;
			yield return new WaitForSeconds(frequency);

			fetchData ("VSync");        //Screen
			fetchData ("Contacts");	    //Vibra
			fetchData ("Mesh Memory");  //Tone


		}
	}

	public void Init() {
		statisticProperties = ProfilerDriver.GetAllStatisticsProperties ();
		ProfilerDriver.ClearAllFrames ();
		Profiler.enabled = true;
		OSCHandler.Instance.Init (host, port);


	}

	public void fetchData(string attribute) {
		data = new float[buffersize];

		int frameIndex = ProfilerDriver.GetPreviousFrameIndex(0);
		int guid = -1;


		try 
		{
			guid = ProfilerDriver.GetStatisticsIdentifier(attribute);
		}
		catch (Exception e) 
		{
			
		}

		if (guid >= 0) 
		{
			string string_formatted = ProfilerDriver.GetFormattedStatisticsValue (frameIndex, guid);
			OSCHandler.Instance.SendMessageToClient ("UnityMonitor", "/profiler/"+attribute, string_formatted);

		}


		// int guid = ProfilerDriver.GetStatisticsIdentifier ("Number of Contacts");
		// int guid = ProfilerDriver.GetStatisticsIdentifier ("Active Rigidbodies");

//		ProfilerDridver.GetStatisticsValues (guid, 0, 1, data, out maxValue);
		// Debug.Log ("next: "+next);
		//		Debug.Log ("Data: "+data[next]);
		//		Debug.Log ("MaxVal: "+maxValue);

	}
}