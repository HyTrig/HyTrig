<<A, B>> G ! Caught: true
0- RootNode  initial - # Children: 1
Valuation: {ball = -10.0   middle_player = 0.0   spd = 0.0   time = 0.0   }

0- TriggerNode initial - Time: 0.0 - Agent: A - Trigger: (ball <= -9.5) - # Children: 1
Valuation: {ball = -10.0   middle_player = 0.0   spd = 0.0   time = 0.0   }

	1- DecisionNode A_Throwing - Time: 0.0 - Agent: A - Action: throw_1 - # Children: 1
	Valuation: {ball = -10.0   middle_player = 0.0   spd = 1.0   time = 0.0   }

		2- TriggerNode A_Throwing - Time: 19.5 - Agent: B - Trigger: (ball >= 9.5) - # Children: 1
		Valuation: {ball = 9.5   middle_player = 0.40837   spd = 1.0   time = 19.5   }

			3- DecisionNode B_Throwing - Time: 19.5 - Agent: B - Action: throw_1 - # Children: 1
			Valuation: {ball = 9.5   middle_player = 0.40837   spd = -1.0   time = 19.5   }

				4- TriggerNode B_Throwing - Time: 38.5 - Agent: A - Trigger: (ball <= -9.5) - # Children: 1
				Valuation: {ball = -9.5   middle_player = 0.60786   spd = -1.0   time = 38.49999   }

					5- DecisionNode A_Throwing - Time: 38.5 - Agent: A - Action: throw_1 - # Children: 1
					Valuation: {ball = -9.5   middle_player = 0.60786   spd = 1.0   time = 38.49999   }

						6- TriggerNode A_Throwing - Time: 57.5 - Agent: B - Trigger: (ball >= 9.5) - # Children: 1
						Valuation: {ball = 9.5   middle_player = 0.83879   spd = 1.0   time = 57.49999   }

							7- DecisionNode B_Throwing - Time: 57.5 - Agent: B - Action: throw_1 - # Children: 1
							Valuation: {ball = 9.5   middle_player = 0.83879   spd = -1.0   time = 57.49999   }

								8- TriggerNode B_Throwing - Time: 76.5 - Agent: A - Trigger: (ball <= -9.5) - # Children: 1
								Valuation: {ball = -9.5   middle_player = 1.09596   spd = -1.0   time = 76.49999   }

									9- DecisionNode A_Throwing - Time: 76.5 - Agent: A - Action: throw_1 - # Children: 1
									Valuation: {ball = -9.5   middle_player = 1.09596   spd = 1.0   time = 76.49999   }

										10- TriggerNode A_Throwing - Time: 95.5 - Agent: B - Trigger: (ball >= 9.5) - # Children: 1
										Valuation: {ball = 9.5   middle_player = 1.37357   spd = 1.0   time = 95.49999   }

											11- DecisionNode B_Throwing - Time: 95.5 - Agent: B - Action: throw_1 - # Children: 1
											Valuation: {ball = 9.5   middle_player = 1.37357   spd = -1.0   time = 95.49999   }

												12- TriggerNode B_Throwing - Time: 114.5 - Agent: A - Trigger: (ball <= -9.5) - # Children: 1
												Valuation: {ball = -9.5   middle_player = 1.66531   spd = -1.0   time = 114.49999   }

													13- DecisionNode A_Throwing - Time: 114.5 - Agent: A - Action: throw_1 - # Children: 1
													Valuation: {ball = -9.5   middle_player = 1.66531   spd = 1.0   time = 114.49999   }

														14- TriggerNode A_Throwing - Time: 133.5 - Agent: B - Trigger: (ball >= 9.5) - # Children: 1
														Valuation: {ball = 9.5   middle_player = 1.96462   spd = 1.0   time = 133.49999   }

															15- DecisionNode B_Throwing - Time: 133.5 - Agent: B - Action: throw_1 - # Children: 1
															Valuation: {ball = 9.5   middle_player = 1.96462   spd = -1.0   time = 133.49999   }

																16- TriggerNode B_Throwing - Time: 152.5 - Agent: A - Trigger: (ball <= -9.5) - # Children: 1
																Valuation: {ball = -9.5   middle_player = 2.26474   spd = -1.0   time = 152.5   }

																	17- DecisionNode A_Throwing - Time: 152.5 - Agent: A - Action: throw_1 - # Children: 1
																	Valuation: {ball = -9.5   middle_player = 2.26474   spd = 1.0   time = 152.5   }

																		18- TriggerNode A_Throwing - Time: 171.5 - Agent: B - Trigger: (ball >= 9.5) - # Children: 1
																		Valuation: {ball = 9.5   middle_player = 2.55887   spd = 1.0   time = 171.5   }

																			19- DecisionNode B_Throwing - Time: 171.5 - Agent: B - Action: throw_1 - # Children: 1
																			Valuation: {ball = 9.5   middle_player = 2.55887   spd = -1.0   time = 171.5   }

																				20- TriggerNode B_Throwing - Time: 190.5 - Agent: A - Trigger: (ball <= -9.5) - # Children: 1
																				Valuation: {ball = -9.5   middle_player = 2.84036   spd = -1.0   time = 190.49999   }

																					21- DecisionNode A_Throwing - Time: 190.5 - Agent: A - Action: throw_1 - # Children: 1
																					Valuation: {ball = -9.5   middle_player = 2.84036   spd = 1.0   time = 190.49999   }

																						22- TriggerNode A_Throwing - Time: 209.5 - Agent: B - Trigger: (ball >= 9.5) - # Children: 1
																						Valuation: {ball = 9.5   middle_player = 3.10287   spd = 1.0   time = 209.49999   }

																							23- DecisionNode B_Throwing - Time: 209.5 - Agent: B - Action: throw_1 - # Children: 1
																							Valuation: {ball = 9.5   middle_player = 3.10287   spd = -1.0   time = 209.49999   }

																								24- TriggerNode B_Throwing - Time: 228.5 - Agent: A - Trigger: (ball <= -9.5) - # Children: 1
																								Valuation: {ball = -9.5   middle_player = 3.34048   spd = -1.0   time = 228.49999   }

																									25- DecisionNode A_Throwing - Time: 228.5 - Agent: A - Action: throw_1 - # Children: 1
																									Valuation: {ball = -9.5   middle_player = 3.34048   spd = 1.0   time = 228.49999   }

																										26- TriggerNode A_Throwing - Time: 247.5 - Agent: B - Trigger: (ball >= 9.5) - # Children: 1
																										Valuation: {ball = 9.5   middle_player = 3.54781   spd = 1.0   time = 247.49999   }

																											27- DecisionNode B_Throwing - Time: 247.5 - Agent: B - Action: throw_1 - # Children: 2
																											Valuation: {ball = 9.5   middle_player = 3.54781   spd = -1.0   time = 247.49999   }

																												28- TriggerNode B_Throwing - Time: 257.0434 - Agent: C - Trigger: (((ball ^ 2.0) + (middle_player ^ 2.0)) <= 0.1) - # Children: 1
																												Valuation: {ball = -0.04337   middle_player = 0.31324   spd = -1.0   time = 257.04336   }

																													29- DecisionNode Caught - Time: 257.0434 - Agent: C - Action: catch - # Children: 1
																													Valuation: {ball = -0.04337   middle_player = 0.31324   spd = -1.0   time = 257.04336   }

																														30- TerminalNode - Caught - Time: 1000.0
																														Valuation: {ball = -0.04337   middle_player = 0.31324   spd = -1.0   time = 257.04336   }

																												28- TriggerNode B_Throwing - Time: 266.5 - Agent: A - Trigger: (ball <= -9.5) - # Children: 1
																												Valuation: {ball = -9.5   middle_player = 3.72017   spd = -1.0   time = 266.5   }

																													29- DecisionNode A_Throwing - Time: 266.5 - Agent: A - Action: throw_1 - # Children: 2
																													Valuation: {ball = -9.5   middle_player = 3.72017   spd = 1.0   time = 266.5   }

																														30- TriggerNode A_Throwing - Time: 275.9041 - Agent: C - Trigger: (((ball ^ 2.0) + (middle_player ^ 2.0)) <= 0.1) - # Children: 1
																														Valuation: {ball = -0.0959   middle_player = 0.30134   spd = 1.0   time = 275.90409   }

																															31- DecisionNode Caught - Time: 275.9041 - Agent: C - Action: catch - # Children: 1
																															Valuation: {ball = -0.0959   middle_player = 0.30134   spd = 1.0   time = 275.90409   }

																																32- TerminalNode - Caught - Time: 1000.0
																																Valuation: {ball = -0.0959   middle_player = 0.30134   spd = 1.0   time = 275.90409   }

																														30- TriggerNode A_Throwing - Time: 285.5 - Agent: B - Trigger: (ball >= 9.5) - # Children: 1
																														Valuation: {ball = 9.5   middle_player = 3.85366   spd = 1.0   time = 285.5   }

																															31- DecisionNode B_Throwing - Time: 285.5 - Agent: B - Action: throw_1 - # Children: 2
																															Valuation: {ball = 9.5   middle_player = 3.85366   spd = -1.0   time = 285.5   }

																																32- TriggerNode B_Throwing - Time: 294.8052 - Agent: C - Trigger: (((ball ^ 2.0) + (middle_player ^ 2.0)) <= 0.1) - # Children: 1
																																Valuation: {ball = 0.19475   middle_player = 0.24914   spd = -1.0   time = 294.80525   }

																																	33- DecisionNode Caught - Time: 294.8052 - Agent: C - Action: catch - # Children: 1
																																	Valuation: {ball = 0.19475   middle_player = 0.24914   spd = -1.0   time = 294.80525   }

																																		34- TerminalNode - Caught - Time: 1000.0
																																		Valuation: {ball = 0.19475   middle_player = 0.24914   spd = -1.0   time = 294.80525   }

																																32- TriggerNode B_Throwing - Time: 304.5 - Agent: A - Trigger: (ball <= -9.5) - # Children: 1
																																Valuation: {ball = -9.5   middle_player = 3.94529   spd = -1.0   time = 304.5   }

																																	33- DecisionNode A_Throwing - Time: 304.5 - Agent: A - Action: throw_1 - # Children: 2
																																	Valuation: {ball = -9.5   middle_player = 3.94529   spd = 1.0   time = 304.5   }

																																		34- TriggerNode A_Throwing - Time: 313.737 - Agent: C - Trigger: (((ball ^ 2.0) + (middle_player ^ 2.0)) <= 0.1) - # Children: 1
																																		Valuation: {ball = -0.26296   middle_player = 0.17565   spd = 1.0   time = 313.73705   }

																																			35- DecisionNode Caught - Time: 313.737 - Agent: C - Action: catch - # Children: 1
																																			Valuation: {ball = -0.26296   middle_player = 0.17565   spd = 1.0   time = 313.73705   }

																																				36- TerminalNode - Caught - Time: 1000.0
																																				Valuation: {ball = -0.26296   middle_player = 0.17565   spd = 1.0   time = 313.73705   }

																																		34- TriggerNode A_Throwing - Time: 323.5 - Agent: B - Trigger: (ball >= 9.5) - # Children: 1
																																		Valuation: {ball = 9.5   middle_player = 3.99296   spd = 1.0   time = 323.50001   }

																																			35- DecisionNode B_Throwing - Time: 323.5 - Agent: B - Action: throw_1 - # Children: 2
																																			Valuation: {ball = 9.5   middle_player = 3.99296   spd = -1.0   time = 323.50001   }

																																				36- TriggerNode B_Throwing - Time: 332.6985 - Agent: C - Trigger: (((ball ^ 2.0) + (middle_player ^ 2.0)) <= 0.1) - # Children: 1
																																				Valuation: {ball = 0.30146   middle_player = 0.09552   spd = -1.0   time = 332.69855   }

																																					37- DecisionNode Caught - Time: 332.6985 - Agent: C - Action: catch - # Children: 1
																																					Valuation: {ball = 0.30146   middle_player = 0.09552   spd = -1.0   time = 332.69855   }

																																						38- TerminalNode - Caught - Time: 1000.0
																																						Valuation: {ball = 0.30146   middle_player = 0.09552   spd = -1.0   time = 332.69855   }

																																				36- TriggerNode B_Throwing - Time: 342.5 - Agent: A - Trigger: (ball <= -9.5) - # Children: 1
																																				Valuation: {ball = -9.5   middle_player = 3.99562   spd = -1.0   time = 342.50001   }

																																					37- DecisionNode A_Throwing - Time: 342.5 - Agent: A - Action: throw_1 - # Children: 2
																																					Valuation: {ball = -9.5   middle_player = 3.99562   spd = 1.0   time = 342.50001   }

																																						38- TriggerNode A_Throwing - Time: 351.6852 - Agent: C - Trigger: (((ball ^ 2.0) + (middle_player ^ 2.0)) <= 0.1) - # Children: 1
																																						Valuation: {ball = -0.31481   middle_player = 0.02994   spd = 1.0   time = 351.6852   }

																																							39- DecisionNode Caught - Time: 351.6852 - Agent: C - Action: catch - # Children: 1
																																							Valuation: {ball = -0.31481   middle_player = 0.02994   spd = 1.0   time = 351.6852   }

																																								40- TerminalNode - Caught - Time: 351.6852
																																								Valuation: {ball = -0.31481   middle_player = 0.02994   spd = 1.0   time = 351.6852   }

																																						38- TriggerNode A_Throwing - Time: 361.5 - Agent: B - Trigger: (ball >= 9.5) - # Children: 1
																																						Valuation: {ball = 9.5   middle_player = 3.95318   spd = 1.0   time = 361.50001   }

																																							39- DecisionNode B_Throwing - Time: 361.5 - Agent: B - Action: throw_1 - # Children: 1
																																							Valuation: {ball = 9.5   middle_player = 3.95318   spd = -1.0   time = 361.50001   }

																																								40- TerminalNode - B_Throwing - Time: 361.5
																																								Valuation: {ball = 9.5   middle_player = 3.95318   spd = -1.0   time = 361.50001   }




***************************
***************************
***************************


