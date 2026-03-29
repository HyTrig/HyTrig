<<A>> F (pos < 0 || pos > 1000): false
0- RootNode  falling - # Children: 0
Valuation: {pos = 1000.0   spd = 0.0   acc = -10.0   dissipation = 0.9   }




***************************
***************************
***************************


<<A>> G pos >= 0: true
0- RootNode  falling - # Children: 1
Valuation: {pos = 1000.0   spd = 0.0   acc = -10.0   dissipation = 0.9   }

0- TriggerNode falling - Time: 14.14214 - Agent: A - Trigger: ((pos == 0.0)) && ((spd < 0.0)) - # Children: 1
Valuation: {pos = 0.0   spd = -141.42136   acc = -10.0   dissipation = 0.9   }

	1- DecisionNode falling - Time: 14.14214 - Agent: A - Action: up - # Children: 1
	Valuation: {pos = 0.0   spd = 127.27922   acc = -10.0   dissipation = 0.9   }

		2- TriggerNode falling - Time: 39.59798 - Agent: A - Trigger: ((pos == 0.0)) && ((spd < 0.0)) - # Children: 1
		Valuation: {pos = -0.0   spd = -127.27922   acc = -10.0   dissipation = 0.9   }

			3- DecisionNode falling - Time: 39.59798 - Agent: A - Action: up - # Children: 1
			Valuation: {pos = -0.0   spd = 114.5513   acc = -10.0   dissipation = 0.9   }

				4- TriggerNode falling - Time: 62.50824 - Agent: A - Trigger: ((pos == 0.0)) && ((spd < 0.0)) - # Children: 1
				Valuation: {pos = 0.0   spd = -114.55129   acc = -10.0   dissipation = 0.9   }

					5- DecisionNode falling - Time: 62.50824 - Agent: A - Action: up - # Children: 1
					Valuation: {pos = 0.0   spd = 103.09616   acc = -10.0   dissipation = 0.9   }

						6- TriggerNode falling - Time: 83.12747 - Agent: A - Trigger: ((pos == 0.0)) && ((spd < 0.0)) - # Children: 1
						Valuation: {pos = -0.0   spd = -103.09615   acc = -10.0   dissipation = 0.9   }

							7- DecisionNode falling - Time: 83.12747 - Agent: A - Action: up - # Children: 1
							Valuation: {pos = -0.0   spd = 92.78654   acc = -10.0   dissipation = 0.9   }

								8- TerminalNode - falling - Time: 100.0
								Valuation: {pos = 142.13223   spd = -75.93877   acc = -10.0   dissipation = 0.9   }




***************************
***************************
***************************


<<A>> F (pos == 700 && spd > 0): true
0- RootNode  falling - # Children: 1
Valuation: {pos = 1000.0   spd = 0.0   acc = -10.0   dissipation = 0.9   }

0- TriggerNode falling - Time: 14.14214 - Agent: A - Trigger: ((pos == 0.0)) && ((spd < 0.0)) - # Children: 1
Valuation: {pos = 0.0   spd = -141.42136   acc = -10.0   dissipation = 0.9   }

	1- DecisionNode falling - Time: 14.14214 - Agent: A - Action: up - # Children: 1
	Valuation: {pos = 0.0   spd = 127.27922   acc = -10.0   dissipation = 0.9   }

		2- PropertyNode - falling - Time: 22.17965
		Valuation: {pos = 700.0   spd = 46.90416   acc = -10.0   dissipation = 0.9   }




***************************
***************************
***************************


